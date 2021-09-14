import IModel from "../../common/IModel.interface";

class CategoryModel implements IModel {
    id: number;
    category: number;
    name: any;
}

export default CategoryModel;