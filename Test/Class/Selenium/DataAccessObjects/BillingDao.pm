package Test::Class::Selenium::DataAccessObjects::BillingDao;

use strict;
use warnings;
use Test::Class::Selenium::DataAccessObjects::BaseDao;

use base 'Test::Class::Selenium::DataAccessObjects::BaseDao';


=head1 NAME

BillingDao

=head1 SYNOPSIS

dao::BillingDao Package

=head1 DESCRIPTION

This class encapsulates the functionality associated with Billing data access objects.

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

=head2 get_most_recent_billingperiod_by_property_id

Query the most recent bilingperiod by $property_id

returns @hash of billingperiod columns

=item $billingperiod{billingperiod_id}
=item $billingperiod{bililingstatus_xt}
=item $billingperiod{start_dm}
=item $billingperiod{end_dm}
=item $billingperiod{min_cutoff_dm}
=item $billingperiod{min_units}

=cut

sub get_most_recent_billingperiod_hash_by_property_id {
    my ( $self, $property_id ) = @_;
    
	my $dbh;

	$dbh = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $sth = $dbh->prepare(		   
			'SELECT * 
			FROM tblbillingperiod 
			WHERE property_id = ?
			ORDER BY create_dm DESC') or die "Couldn't prepare statement: " . $dbh->errstr;

	$sth->execute($property_id)             # Execute the query
			or die "Couldn't execute statement: " . $sth->errstr;
	
	my @data = $sth->fetchrow_array();
	
	my %billingperiod = (
			'billingperiod_id' => $data[0],
			'bililingstatus_xt' => $data[3],
			'start_dm' => $data[4],
			'end_dm' => $data[5],
			'min_cutoff_dm' => $data[11],
			'min_units' => $data[12]
	);

	print "\n# $billingperiod{billingperiod_id} : $billingperiod{bililingstatus_xt} : $billingperiod{start_dm} : $billingperiod{end_dm} : $billingperiod{min_cutoff_dm} : $billingperiod{min_units}\n";

	if ($sth->rows == 0) {
		print "No billing periods of property `$property_id'.\n\n";
	}

	$sth->finish;

	#print "\n# Property id:  ".$property_id."\n";

	$dbh->disconnect;

	return %billingperiod;

}

sub get_property_renew_status
{
	my ( $self, $property_id ) = @_;
	
	my $dbh;

	$dbh = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $renew_status = $dbh->selectrow_array(
		"SELECT renew_status
		 FROM vwproperty_all2
		 WHERE property_id = $property_id"
	);
	
	print "\n# Renew Status of property ID ".$property_id." in DB = ".$renew_status."\n";
	
	$dbh->disconnect;
		
	return $renew_status;
}

1;

}