(function ()
{
    'use strict';

    /**
     * Main module of the Fuse
     */
    angular
        .module('fuse', [

            // Core
            'app.core',

            // Navigation
            'app.navigation',

            // Toolbar
            'app.toolbar',

            // Quick panel
            'app.quick-panel',

            // Auth
            'app.auth.login',
            'app.auth.lock',

            // Test
            'app.box',
            'app.plan',
            'app.execution',

            // Manager
            'app.comp-admin',
            'app.ea-admin'
        ]);
})();
