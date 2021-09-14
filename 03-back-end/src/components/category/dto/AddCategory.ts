import Ajv from 'ajv';

interface IAddCategory {
    name: any;
    id: number;
    category: number;
}

const ajv = new Ajv();

const IAddCategoryValidator = ajv.compile({
    type: "object",
    properties: {
        id: {
            type: "number",
            minLength: 2,
            maxLength: 32,
        },
        category: {
            type: "number",
            maxLength: 255,
        },  
    },
    required: [
        "id",
        "category"
    ],
    additionalProperties: false
});

export { IAddCategory };
export { IAddCategoryValidator };