package smd.server.base.module;

import harfang.module.AbstractModule;
import harfang.configuration.MacroConfigurator;
import server.base.controller.UserController;


/**
 * Test demo application
 */
class Base extends AbstractModule {

    /**
     * Constructs the Demo server module
     */
    public function new() {
        super();
		MacroConfigurator.mapController(this, UserController, "URL");
    }
}