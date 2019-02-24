# This class is for configuring a system for running SQL Server
#
# Components:
# - SQLServer software install
# - instance creation
# - instance dba user created / configured
# - firewall access to system
#
# @summary our wrapper around a sql server
#
# @example
#   include profile::sqlserver
#   and have your data in hiera
class profile::sqlserver (
  String $db_name,
  String $dba_user,
  String $dba_pass,
  Hash $db_accts, # should map to the profile::sqlserver::acct resource type. Only for simple users configurations
  String $installation_source,
) {

  sqlserver_instance{ $db_name:
    source                => 'E:/',
    security_mode         => 'SQL',
    sa_pwd                => $sapwd,
    features              => [
      'SQL',
      'SQLEngine',
    ],
    sql_sysadmin_accounts => ['vagrant'],
  }

  sqlserver::config{ $db_name:
    admin_user => 'sa',
    admin_pass => 'Pupp3t1@',
    require    => Mssql_instance[$instance_name],
  }

  sqlserver::login{ 'padmin':
    password => $dba_pass,
    instance => $instance_name,
  }
}
