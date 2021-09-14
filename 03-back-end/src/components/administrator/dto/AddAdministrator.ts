import Ajv from 'ajv';

interface IAddAdministrator {
    first_name: string;
    password: string;
    idRole: number;
}

const ajv = new Ajv();

const IAddAdministratorValidator = ajv.compile({
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
        "username",
        "password",
        "idRole"
    ],
    additionalProperties: false
});

export { IAddAdministrator };
export { IAddAdministratorValidator };