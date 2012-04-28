package smd.server.ka;

import harfang.module.AbstractModule;
import harfang.configuration.MacroConfigurator;
import smd.server.ka.controller.SiteController;


class Site extends AbstractModule {

    public function new() {
        super();
		MacroConfigurator.mapController(this, SiteController, "URL");
    }
}