import Ajv from 'ajv';

interface IEditCategory {
    name: any;
    id: number;
    category: number;
}

const ajv = new Ajv();

const IEditCategoryValidator = ajv.compile({
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
    required: [],
    additionalProperties: false
});

export { IEditCategory };
export { IEditCategoryValidator };