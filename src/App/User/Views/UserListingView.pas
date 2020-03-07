(*!------------------------------------------------------------
 * Fano Web Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app-db
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-app-db/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit UserListingView;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano;

type

    (*!-----------------------------------------------
     * View instance for user listing page
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *------------------------------------------------*)
    TUserListingView = class(TInjectableObject, IView)
    private
        userModel : IModelReader;
        fBaseTpl : IViewPartial;
        fBaseTemplatePath : string;
    public
        constructor create(
            const usr : IModelReader;
            const baseTpl : IViewPartial
        );
        destructor destroy(); override;

        (*!------------------------------------------------
         * render view
         *------------------------------------------------
         * @param viewParams view parameters
         * @param response response instance
         * @return response
         *-----------------------------------------------*)
        function render(
            const viewParams : IViewParameters;
            const response : IResponse
        ) : IResponse;
    end;

implementation

uses

    SysUtils;

    constructor TUserListingView.create(
        const usr : IModelReader;
        const baseTpl : IViewPartial
    );
    begin
        userModel := usr;
        fBaseTpl := baseTpl;
        fBaseTemplatePath := getCurrentDir() + '/resources/Templates/base.template.html';
    end;

    destructor TUserListingView.destroy();
    begin
        fBaseTpl := nil;
        userModel := nil;
        inherited destroy();
    end;

    (*!------------------------------------------------
     * render view
     *------------------------------------------------
     * @param viewParams view parameters
     * @param response response instance
     * @return response
     *-----------------------------------------------*)
    function TUserListingView.render(
        const viewParams : IViewParameters;
        const response : IResponse
    ) : IResponse;
    var userData : IModelResultSet;
        respBody : IResponseStream;
        mainContent : string;
    begin
        userData := userModel.data();
        respBody := response.body();
        mainContent := '';
        if (userData.count() > 0) then
        begin
            mainContent :=
                '<div class="container has-text-centered">' +
                '<div class="column">' +
                '<table class="table is-fullwidth is-hoverable">' +
                '<thead>' +
                  '<tr>' +
                  '  <th>No</th>' +
                  '  <th>Name</th>' +
                  '  <th>Email</th>' +
                  '</tr>' +
                '</thead><tbody>';
            while (not userData.eof()) do
            begin
                mainContent := mainContent +
                    '<tr>' +
                    '<td>' + userData.readString('id') + '</td>' +
                    '<td>' + userData.readString('name') + '</td>' +
                    '<td>' + userData.readString('email') + '</td>' +
                    '</tr>';
                userData.next();
            end;
            mainContent := mainContent + '</tbody></table></div></div>';
        end;

        viewParams['mainContent'] := mainContent;
        respBody.write(
            fBaseTpl.partial(
                fBaseTemplatePath,
                viewParams
            )
        );
        result := response;
    end;

end.
