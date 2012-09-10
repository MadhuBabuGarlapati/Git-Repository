package Test::Class::Selenium::DataAccessObjects::PLTDao;

use strict;
use warnings;
use Test::Class::Selenium::DataAccessObjects::BaseDao;

use base 'Test::Class::Selenium::DataAccessObjects::BaseDao';


=head1 NAME

LandingPage

=head1 SYNOPSIS

dao::PLTDao Package

=head1 DESCRIPTION

This class encapsulates the functionality associated with PLT data access objects.

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
=head2 find_property_id_by_email()

Returns the news created property from the email provided.

=cut

sub get_most_recent_property_id_from_email {

    my ( $self, $email ) = @_;
    
    
	my $db;
	my $property_id = '';
	
	

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	$property_id = $db->selectrow_array(
		"select property_id from tblproperty_company
         where company_id in (
         SELECT company_id from (
            SELECT company_id, create_dm
            FROM tblperson_company
            WHERE person_id IN
            (
                 SELECT person_id
                 FROM tblperson
                WHERE TRIM(LOWER(person_nm)) = TRIM(LOWER('".$email."'))
            )
            ORDER BY create_dm DESC    
        )
        WHERE ROWNUM <= 1)"
	);
	
	#print "\n#Property id:  ".$property_id."\n";
	
	$db->disconnect;
		
	return $property_id;
}

=head2 get_personid_for_plt()

Returns the personid for a new plt.

=cut

sub get_personid_for_plt {

    my ( $self, $email ) = @_;
    
    
	my $db;
	my $personid = '';
	
	

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	$personid = $db->selectrow_array(
		"SELECT person_id
         FROM tblperson
         WHERE TRIM(LOWER(person_nm)) = TRIM(LOWER('".$email."'))"
	);
	
	#print "\n#Person id:  ".$personid."\n";
	
	$db->disconnect;
		
	return $personid;
}

=head2 get_companyid_from_personi()

Returns the company id for a new plt.

=cut

sub get_companyid_from_personid {

    my ( $self, $personid ) = @_;
    
    
	my $db;
	my $companyid;
	

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	$companyid = $db->selectrow_array(
		"SELECT company_id
         FROM tblperson_company
         WHERE person_id = $personid"
	);
	
	#print "\n#Company id:  ".$companyid."\n";
	
	$db->disconnect;
		
	return $companyid;
}

=head2 get_cctransaction_from_personid()

Returns the cctransaction id for a new plt.

=cut

sub get_cctransaction_from_personid {

    my ( $self, $personid ) = @_;
    
    
	my $db;
	my $cctransaction_id;
	

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	$cctransaction_id = $db->selectrow_array(
		"SELECT cctransaction_id
         FROM tblcctransaction
         WHERE person_id = $personid"
	);
	
	#print "\n#Transaction id:  ".$cctransaction_id."\n";
	
	$db->disconnect;
		
	return $cctransaction_id;
}


=head2 get_company_data()

Returns company data for a new plt.

=cut

sub get_company_data {

    my ( $self, $companyid ) = @_;
    
    
	my $db;
	my $company_nm;
	

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	$company_nm = $db->selectrow_array(
		"SELECT company_nm
         FROM tblcompany
         WHERE company_id = $companyid"
	);
	
	#print "\n#Company Name:  ".$company_nm."\n";
	
	$db->disconnect;
		
	return $company_nm;
}

=head2 get_property_contact_data()

Returns property contact data for a new plt.

=cut

sub get_property_contact_data {

    my ( $self, $propertyid ) = @_;
    
    
	my $db;
	my $property_tp;
	

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	$property_tp = $db->selectrow_array(
		"SELECT phone_nm
         FROM tblpropertycontact
         WHERE property_id = $propertyid"
	);
	
	#print "\n#Property phone:  ".$property_tp."\n";
	
	$db->disconnect;
		
	return $property_tp;
}

1;

}
