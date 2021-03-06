import BaseController from "../../common/BaseController";
import { Request, Response, NextFunction } from "express";
import AdministratorModel from "./model";
import IErrorResponse from "../../common/IErrorResponse.interface";
import { IAddAdministrator, IAddAdministratorValidator, } from "./dto/AddAdministrator";
import { IEditAdministrator, IEditAdministratorValidator } from "./dto/EditAdministrator";

class AdministratorController extends BaseController {
    public async getAll(req: Request, res: Response, next: NextFunction) {
        const administrators = await this.services.administratorService.getAll();
        res.send(administrators);
    }

    public async getById(req: Request, res: Response, next: NextFunction) {
        const id = +(req.params.id);
        const roleID: number = +id;

        if (roleID <= 0) {
            res.sendStatus(400);
            return;
        }

        const data: AdministratorModel|null|IErrorResponse = await this.services.administratorService.getById(roleID);

        if (data === null) {
            res.sendStatus(404);
            return;
        }

        if (data instanceof AdministratorModel) {
            res.send(data);
            return;
        }

        res.status(500).send(data);
    }

    public async add(req: Request, res: Response, next: NextFunction) {
        const data = req.body;

        if (!IAddAdministratorValidator(data)) {
            res.status(400).send(IAddAdministratorValidator.errors);
            return;
        }

        const result =  await this.services.administratorService.add(data as IAddAdministrator);

        res.send(result);
    }

    public async edit(req: Request, res: Response, next: NextFunction) {
        const data = req.body;
        const id = +(req.params.id);
        const roleId: number = +id

        if (roleId <= 0) {
            res.status(400).send("Invalid ID number");
            return;
        }
        if (!IEditAdministratorValidator(data)) {
            res.status(400).send(IEditAdministratorValidator.errors);
            return;
        }

        const result =  await this.services.administratorService.edit(roleId, data as IEditAdministrator);

        if (result === null) {
            res.sendStatus(404);
            return;
        }

        res.send(result);
    }

    public async delete(req: Request, res: Response, next: NextFunction) {
        const id = +(req.params.id);    

        if (id <= 0) return res.status(400).send("The ID value cannot be smaller than 1");

        res.send(await this.services.administratorService.delete(id));
    }
}

export default AdministratorController