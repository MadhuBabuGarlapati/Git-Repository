package Test::Class::Selenium::DataAccessObjects::MITSDao;

use strict;
use warnings;
use Test::Class::Selenium::DataAccessObjects::BaseDao;
use base 'Test::Class::Selenium::DataAccessObjects::BaseDao';

=head1 NAME

MITSDao

=head1 SYNOPSIS

=head1 DESCRIPTION

This class encapsulates the functionality associated with MITS.

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	

=item 

=cut

sub new {
    my $class = shift;
    my $self = {
		_database => shift,
        _db_username => shift,
        _db_password => shift,
    };
 
    bless $self, $class or die "Can't bless $class: $!";

    return $self; 
}

=head2 get_propertyid_by_companyid_and_primaryid

Return property_id by company_id and primary_id

=cut

sub get_propertyid_by_companyid_and_primaryid {
	my ( $self, $company_id, $primary_id,  ) = @_;
	
	my $db;
	my $property_id = "";

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	#Removed $company_id from the query for now, since it seems like we don't need it
	$property_id = $db->selectrow_array(qq{
		select property_id 
		from vwproperty_all2 
		where external_id = '$primary_id'
	});
	
	if ( ! defined($property_id)) {
		$property_id = "";
	}

	print "\n#$property_id:  ".$property_id."\n";

	$db->disconnect();

	return $property_id;
}

1;

}
