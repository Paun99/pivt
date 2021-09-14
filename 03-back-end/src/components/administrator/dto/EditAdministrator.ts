import Ajv from 'ajv';

interface IEditAdministrator {
    first_name: any;
    username: string;
    password: string;
    idRole: number;
}

const ajv = new Ajv();

const IEditAdministratorValidator = ajv.compile({
    type: "object",
    properties: {
        username: {
            type: "string",
            minLength: 2,
            maxLength: 32,
        },
        password: {
            type: "string",
            minLength: 8,
            maxLength: 255,
        },
        idRole: {
            type: "number",
            minLength: 1,
            maxLength: 1,
        },
    },
    required: [
        
    ],
    additionalProperties: false
});

export { IEditAdministrator };
export { IEditAdministratorValidator };