import { Test, TestingModule } from '@nestjs/testing';
import { MicroProjectController } from './micro-project.controller';
import { MicroProjectService } from './micro-project.service';

describe('MicroProjectController', () => {
  let microProjectController: MicroProjectController;

  beforeEach(async () => {
    const app: TestingModule = await Test.createTestingModule({
      controllers: [MicroProjectController],
      providers: [MicroProjectService],
    }).compile();

    microProjectController = app.get<MicroProjectController>(MicroProjectController);
  });

  describe('root', () => {
    it('should return "Hello World!"', () => {
      expect(microProjectController.getHello()).toBe('Hello World!');
    });
  });
});
