(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

container.add(
    'dbpool',
    TRdbmsPoolFactory.create(
        //use mysql 5.7
        TMysqlDbFactory.create(
            config.getString('db.mysql.version'),
            config.getString('db.mysql.host'),
            config.getString('db.mysql.database'),
            config.getString('db.mysql.username'),
            config.getString('db.mysql.password'),
            config.getInt('db.mysql.port')
        ),
        //create 5 database connection in pool
        5
    )
);

container.add('tplParser', TTemplateParserfactory.create());
