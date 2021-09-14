import Ajv from 'ajv';

interface IAddUser {
    email: any;
   first_name: string;
    password: string;
    address: string;
    roles: number ;
}

const ajv = new Ajv();

const IAddUserValidator = ajv.compile({
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
        "username",
        "password",
        "email",
    ],
    additionalProperties: false
});

export { IAddUser };
export { IAddUserValidator };