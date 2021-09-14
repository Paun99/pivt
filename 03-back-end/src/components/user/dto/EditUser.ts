import Ajv from 'ajv';

interface IEditUser {
    email: any;
    first_name: any;
    username: string;
    password: string;
    address: string;
    roles: number ;
}

const ajv = new Ajv();

const IEditUserValidator = ajv.compile({
    type: "object",
    properties: {
        first_name: {
            type: "string",
            minLength: 2,
            maxLength: 32,
        },
        password: {
            type: "string",
            minLength: 8,
            maxLength: 255,
        },
        address: {
            type: "string",
            minLength: 8,
            maxLength: 255,
        },
        roles: {
            type: "number",
            minLength: 1,
            maxLength: 1,
        },
    },
    required: [
        
    ],
    additionalProperties: false
});

export { IEditUser };
export { IEditUserValidator };