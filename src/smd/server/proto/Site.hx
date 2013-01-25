package smd.server.proto;

import harfang.module.AbstractModule;
import harfang.configuration.MacroConfigurator;
import smd.server.proto.controller.IndexController;

class Site extends AbstractModule {
    public function new() {
        super();		
		MacroConfigurator.mapController(this, IndexController, "URL");
    }
}