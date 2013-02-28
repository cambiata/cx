package karin.server;
import harfang.module.AbstractModule;
import karin.server.controller.IndexController;
import harfang.configuration.MacroConfigurator;
/**
 * ...
 * @author Jonas Nyström
 */
class Site extends AbstractModule {
    public function new() {
        super();		
		MacroConfigurator.mapController(this, IndexController, "URL");
    }
}