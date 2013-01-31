package smd.server.proto.admin;

import harfang.module.AbstractModule;
import harfang.configuration.MacroConfigurator;
import smd.server.base.controller.TestController;
import smd.server.proto.admin.controller.IndexController;

class Site extends AbstractModule {
    public function new() {
        super();		
		MacroConfigurator.mapController(this, IndexController, "URL");
		MacroConfigurator.mapController(this, TestController, "URL");
    }
}