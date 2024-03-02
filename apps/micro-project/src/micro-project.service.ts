import { Injectable } from '@nestjs/common';

@Injectable()
export class MicroProjectService {
  getHello(): string {
    return 'Hello World from micro service!';
  }
}
