import BaseService from "../../common/BaseService";
import IErrorResponse from "../../common/IErrorResponse.interface";
import IModelAdapterOptions from "../../common/IModelAdapterOptions.interface";
import AdministratorModel from "./model";
import * as bcrypt from 'bcrypt';
import { IAddAdministrator } from "./dto/AddAdministrator";
import { IEditAdministrator } from "./dto/EditAdministrator";

class AdministratorModelAdapterOptions implements IModelAdapterOptions {

}

class AdministratorSecvice extends BaseService<AdministratorModel> {
    protected async adaptModel(data: any, options: Partial<AdministratorModelAdapterOptions> = {}): Promise<AdministratorModel> {
        const item = new AdministratorModel();

        item.roleId = data?.roleID;
        item.first_name = data?.first_name;
        item.passwordHash = data?.password_hash;
        item.createdAt = new Date(data?.created_at);

        return item;
    }

    public async getAll(): Promise<AdministratorModel[]|IErrorResponse> {
        return await this.getAllFromTable("administrator");
    }

    public async getById(roleId: number): Promise<AdministratorModel|null|IErrorResponse> {
        return await this.getByIdFromTable("administrator", roleId);
    }

    public async getByfirst_name(first_name: string): Promise<AdministratorModel|null> {
        const administrator =  await this.getAllByFieldName("administrator", "first_name", first_name, {});

        if (!Array.isArray(administrator) || administrator.length === 0) {
            return null;
        }

        return administrator[0];
    }

    public async add(data: IAddAdministrator): Promise<AdministratorModel|IErrorResponse> {
        return new Promise<AdministratorModel|IErrorResponse>(async resolve => {
            const passwordHash = bcrypt.hashSync(data.password, 11)

            const sql: string = "INSERT administrator SET first_name = ?, password_hash = ?;"
            this.db.execute(sql, [data.first_name, passwordHash])
                .then(async res => {
                    const newroleId: number = +((res[0] as any)?.insertId);
                    resolve(await this.getById(newroleId));
                })
                .catch(error => {
                    resolve({
                        errorCode: error?.errno,
                        errorMessage: error?.sqlMessage
                    })
                });
        });
    }

    public async edit(roleId: number,  data: IEditAdministrator): Promise<AdministratorModel|null|IErrorResponse> {
        const result = await this.getById(roleId);

        if (result === null) {
            return null;
        }

        if (!(result instanceof AdministratorModel)) {
            return result;
        }
        
        return new Promise(async resolve => {
            const passwordHash = bcrypt.hashSync(data.password, 11);

            const sql: string = `
                UPDATE 
                    administrator 
                SET 
                    first_name = ?,
                    password_hash = ?
                WHERE
                    roleID = ?;`
            this.db.execute(sql, [data.first_name, passwordHash, roleId])
            .then(async result => {
                resolve(await this.getById(roleId));
            })
            .catch(error => {
                resolve({
                    errorCode: error?.errno,
                    errorMessage: error?.sqlMessage
                })
            });
        });
    }

    public async delete(roleId: number): Promise<IErrorResponse> {
        return new Promise<IErrorResponse>(async resolve => {
            this.db.execute(
                `DELETE FROM administrator WHERE roleID = ?;`,
                [
                    roleId
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

export default AdministratorSecvice;