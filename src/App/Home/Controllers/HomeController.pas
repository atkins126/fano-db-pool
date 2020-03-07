(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit HomeController;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano;

type

    (*!-----------------------------------------------
     * controller that handle route :
     * /home
     *
     * See Routes/Home/routes.inc
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    THomeController = class(TController)
    private
        fUserModel : IModelReader;
    public
        constructor create(
            const viewInst : IView;
            const viewParamsInst : IViewParameters;
            const userModel : IModelReader
        );

        destructor destroy(); override;

        (*!-------------------------------------------
         * handle request
         *--------------------------------------------
         * @param request object represent current request
         * @param response object represent current response
         * @param args object represent current route arguments
         * @return new response
         *--------------------------------------------*)
        function handleRequest(
            const request : IRequest;
            const response : IResponse;
            const args : IRouteArgsReader
        ) : IResponse; override;

    end;

implementation

    constructor THomeController.create(
        const viewInst : IView;
        const viewParamsInst : IViewParameters;
        const userModel : IModelReader
    );
    begin
        inherited create(viewInst, viewParamsInst);
        fUserModel := userModel;
    end;

    destructor THomeController.destroy();
    begin
        fUserModel := nil;
        inherited destroy();
    end;

    (*!-------------------------------------------
     * handle request
     *--------------------------------------------
     * @param request object represent current request
     * @param response object represent current response
     * @return new response
     *--------------------------------------------*)
    function THomeController.handleRequest(
        const request : IRequest;
        const response : IResponse;
        const args : IRouteArgsReader
    ) : IResponse;
    begin
        fUserModel.read();
        result := inherited handleRequest(request, response, args);
    end;

end.
