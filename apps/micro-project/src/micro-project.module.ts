import { Module } from '@nestjs/common';
import { MicroProjectController } from './micro-project.controller';
import { MicroProjectService } from './micro-project.service';

@Module({
  imports: [],
  controllers: [MicroProjectController],
  providers: [MicroProjectService],
})
export class MicroProjectModule {}
