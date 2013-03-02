package karin.server;
import harfang.module.AbstractModule;
import karin.server.controller.AdminController;
import karin.server.controller.IndexController;
import karin.server.controller.InfoController;
import harfang.configuration.MacroConfigurator;
/**
 * ...
 * @author Jonas Nyström
 */
class Site extends AbstractModule {
    public function new() {
        super();		
		MacroConfigurator.mapController(this, IndexController, "URL");
		MacroConfigurator.mapController(this, AdminController, "URL");
		MacroConfigurator.mapController(this, InfoController, "URL");
    }
}