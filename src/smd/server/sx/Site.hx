package smd.server.sx;

import harfang.module.AbstractModule;
import harfang.configuration.MacroConfigurator;
import smd.server.sx.controller.MediaController;
import smd.server.sx.controller.IndexController;

class Site extends AbstractModule {

    public function new() {
        super();
		MacroConfigurator.mapController(this, IndexController, "URL");
		MacroConfigurator.mapController(this, MediaController, "URL");
    }
}