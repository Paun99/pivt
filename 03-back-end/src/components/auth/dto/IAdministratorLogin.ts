import Ajv from "ajv";

interface IAdministratorLogin {
    first_name: string;
    password: string;
}

const ajv = new Ajv();

const IAdministratorLoginValidator = ajv.compile({
    type: "object",
    properties: {
        first_name: {
            type: "string",
            minLength: 5,
            maxLength: 64,
        },
        password: {
            type: "string",
            minLength: 6,
            maxLength: 255,
        }
    },
    required: [
        "first_name",
        "password"
    ],
    additionalProperties: false,
});

export { IAdministratorLogin };
export { IAdministratorLoginValidator };