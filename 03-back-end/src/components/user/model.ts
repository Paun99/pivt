import IModel from "../../common/IModel.interface";

class UserModel implements IModel {
    idRole: number;
    username: string;
    passwordHash: string;
    createdAt: Date;
    email: string;
    first_name: any;
    userId: any;
    roleId: any;
}

export default UserModel;