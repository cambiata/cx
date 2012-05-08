package smd.server.ka;

import harfang.module.AbstractModule;
import harfang.configuration.MacroConfigurator;
import smd.server.ka.controller.ScorxlistController;
import smd.server.ka.controller.SiteController;
import smd.server.ka.controller.IndexController;


class Site extends AbstractModule {

    public function new() {
        super();
		MacroConfigurator.mapController(this, ScorxlistController, "URL");
		MacroConfigurator.mapController(this, SiteController, "URL");
		MacroConfigurator.mapController(this, IndexController, "URL");
    }
}