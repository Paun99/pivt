export default interface ITokenData {
    role: "user"|"administrator";
    
    roleId: number;
    identity: string;
}