import { Controller, Get } from '@nestjs/common';
import { MicroProjectService } from './micro-project.service';
import { MessagePattern } from '@nestjs/microservices';

@Controller()
export class MicroProjectController {
  constructor(private readonly microProjectService: MicroProjectService) {}

  @MessagePattern({cmd: 'get_hello'})
  getHello(): string {
    return this.microProjectService.getHello();
  }
}
