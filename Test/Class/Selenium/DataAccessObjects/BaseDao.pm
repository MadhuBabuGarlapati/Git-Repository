package Test::Class::Selenium::DataAccessObjects::BaseDao;

use strict;
use warnings;
use DBI;

=head1 NAME

Test::Class::Selenium::Util::GenerateData

=head1 SYNOPSIS

Retrieve data from the data base.

=head1 DESCRIPTION

Generate data for testcases

=cut

=item 

Get properties

=cut

{

sub new {

    my $class = shift;
    my $self = {};

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

sub open_db {
	
    my ($self, $database, $db_username, $db_password) = @_;
	
	my $db = DBI->connect("DBI:Oracle:$database", $db_username, $db_password);

	if(!$db){
	     print "# Connection unsuccessful. Please check your login credentials. ".$DBI::errstr;
	}
	else {
		print "# Connection to db successful.";
	}

	return $db;

}

1;

}
