(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit HomeControllerFactory;

interface

{$MODE OBJFPC}
{$H+}

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for controller THomeController
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    THomeControllerFactory = class(TFactory, IDependencyFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses
    sysutils,

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    HomeController;

    function THomeControllerFactory.build(const container : IDependencyContainer) : IDependency;
    var config : IAppConfiguration;
    begin
        config := container['config'] as IAppConfiguration;
        //build your controller instance here.
        //container will gives you access to all registered services
        result := THomeController.create(
            container['usrListView'] as IView,
            TViewParameters.create()
                .setVar('baseUrl', config.getString('baseUrl'))
                .setVar('appName', config.getString('appName')),
            container['userModel'] as IModelReader
        );
    end;
end.
