import BaseService from "../../common/BaseService";
import IErrorResponse from "../../common/IErrorResponse.interface";
import IModelAdapterOptions from "../../common/IModelAdapterOptions.interface";
import UserModel from "./model";
import * as bcrypt from 'bcrypt';
import { IAddUser } from "./dto/AddUser";
import { IEditUser } from "./dto/EditUser";

class UserModelAdapterOptions implements IModelAdapterOptions {
    loadOrders: false;
}

class UserService extends BaseService<UserModel> {
    protected async adaptModel(data: any, options: Partial<UserModelAdapterOptions> = {}): Promise<UserModel> {
        const item = new UserModel();

        item.idRole = data?.idRole;
        item.first_name = data?.first_name;
        item.passwordHash = data?.password_hash;
        item.createdAt = new Date(data?.created_at);
        item.email = data?.email;

        if (options.loadOrders) {
            
        }

        return item;
    }

    public async getAll(): Promise<UserModel[]|IErrorResponse> {
        return await this.getAllFromTable("user");
    }

    public async getById(idRole: number): Promise<UserModel|null|IErrorResponse> {
        return await this.getByIdFromTable("user", idRole);
    }

    public async getByEmail(email: string): Promise<UserModel|null> {
        const user =  await this.getAllByFieldName("user", "email", email, {});

        if (!Array.isArray(user) || user.length === 0) {
            return null;
        }

        return user[0];
    }

    public async add(data: IAddUser): Promise<UserModel|IErrorResponse> {
        return new Promise<UserModel|IErrorResponse>(async resolve => {
            const passwordHash = bcrypt.hashSync(data.password, 11)

            const sql: string = "INSERT user SET first_name = ?, password_hash = ?, email = ?;"
            this.db.execute(sql, [data.first_name, passwordHash, data.email])
                .then(async res => {
                    const newUserId: number = +((res[0] as any)?.insertId);
                    resolve(await this.getById(newUserId));
                })
                .catch(error => {
                    resolve({
                        errorCode: error?.errno,
                        errorMessage: error?.sqlMessage
                    })
                });
        });
    }

    public async edit(idRole: number,  data: IEditUser): Promise<UserModel|null|IErrorResponse> {
        const result = await this.getById(idRole);

        if (result === null) {
            return null;
        }

        if (!(result instanceof UserModel)) {
            return result;
        }
        
        return new Promise(async resolve => {
            const passwordHash = bcrypt.hashSync(data.password, 11);

            const sql: string = `
                UPDATE 
                    user 
                SET 
                    first_name = ?,
                    password_hash = ?,
                    email = ?,
                WHERE
                    idRole = ?;`
            this.db.execute(sql, [data.first_name, passwordHash, data.email, idRole])
            .then(async result => {
                resolve(await this.getById(idRole));
            })
            .catch(error => {
                resolve({
                    errorCode: error?.errno,
                    errorMessage: error?.sqlMessage
                })
            });
        });
    }

    public async delete(idRole: number): Promise<IErrorResponse> {
        return new Promise<IErrorResponse>(async resolve => {
            this.db.execute(
                `DELETE FROM user WHERE idRole = ?;`,
                [
                    idRole
                ]
            )
            .then(res => {
                resolve({
                    errorCode: 0,
                    errorMessage: `Deleted ${(res as any[])[0]?.affectedRows} records.`
                });
            })
            .catch(error => {
                resolve({
                    errorCode: error?.errno,
                    errorMessage: error?.sqlMessage
                })
            });
        })
    }
}

export default UserService;