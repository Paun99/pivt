import IModel from "../../common/IModel.interface";

class AdministratorModel implements IModel {
    roleId: number;
    first_name: string;
    passwordHash: string;
    createdAt: Date;
}

export default AdministratorModel;