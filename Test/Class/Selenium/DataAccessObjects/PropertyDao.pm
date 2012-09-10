package Test::Class::Selenium::DataAccessObjects::PropertyDao;

use strict;
use warnings;
use Test::Class::Selenium::DataAccessObjects::BaseDao;

use base 'Test::Class::Selenium::DataAccessObjects::BaseDao';


=head1 NAME

PropertyDao

=head1 SYNOPSIS

dao::PropertyDao Package

=head1 DESCRIPTION

This class encapsulates the functionality associated with Property data access objects.

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

=head2 get_most_recent_property_by_terminate_xt_and_businessmodel_tp()

Returns most recent property_id by terminate_xt and businessmodel_tp

example terminate_xt = Active, Pre-Registered (Not yet Activated), etc.
examlpe businessmodel_tp = cpa, plt, ppl

=cut

sub get_most_recent_property_by_terminate_xt_and_businessmodel_tp {

    my ( $self, $terminate_xt, $businessmodel_tp ) = @_;
    
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $property_id = $db->selectrow_array(
		   "SELECT property_id
			FROM(
			    SELECT *
			    FROM tblproperty
			    WHERE terminate_xt = '$terminate_xt'
			    AND businessmodel_tp = '$businessmodel_tp'
			    AND salesrepperson_id is NULL
			    AND external_id is NULL
			    ORDER BY tblproperty.property_id DESC
			    )
			WHERE rownum <= 1"
	);
	
	chomp $property_id;
	
	print "\n# Property id:  ".$property_id."\n";
	
	$db->disconnect;
		
	return $property_id;
}

=head2 get_person_nm_by_property_id()

Returns person_nm by property_id

=cut

sub get_person_nm_by_property_id {

    my ( $self, $property_id ) = @_;
    
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $person_nm = $db->selectrow_array(
		"SELECT person_nm FROM tblperson where person_id = (
		    SELECT person_id FROM tblperson_company 
		    WHERE company_id = (
		        SELECT company_id FROM tblproperty_company where property_id = $property_id
			AND LESSOR_FG = 1
			AND TERMINATE_DM IS NULL		    		    
		    )
		)"
	);
	
	print "\n#Person nm:  ".$person_nm."\n";
	
	$db->disconnect;
		
	return $person_nm;
}

=head2 get_person_cd_by_property_id()

Returns person_cd by property_id

=cut

sub get_person_cd_by_property_id {

    my ( $self, $property_id ) = @_;
    
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $person_cd = $db->selectrow_array(
		"SELECT person_cd FROM tblperson where person_id = (
		    SELECT person_id FROM tblperson_company 
		    WHERE company_id = (
		        SELECT company_id FROM tblproperty_company where property_id = $property_id
			AND LESSOR_FG = 1
			AND TERMINATE_DM IS NULL		    		    
		    )
		)"
	);
	
	print "\n#Person cd:  ".$person_cd."\n";
	
	$db->disconnect;
		
	return $person_cd;
}

=head2 get_property_nm_by_property_id()

Returns property_nm by property_id

=cut

sub get_property_nm_by_property_id {

    my ( $self, $property_id ) = @_;
    
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $property_nm = $db->selectrow_array(
		"SELECT property_nm FROM tblproperty where property_id = $property_id"
	);
	
	print "\n#property_nm:  ".$property_nm."\n";
	
	$db->disconnect;
		
	return $property_nm;
}

=head2 get_most_recent_property_by_terminate_xt_and_businessmodel_tp_and_newcontent()

Returns most recent property_id by terminate_xt and businessmodel_tp and if picture is approved

example terminate_xt = Active, Pre-Registered (Not yet Activated), etc.
examlpe businessmodel_tp = cpa, plt, ppl
example $approved_fg = 0, 1


Note:

Part of the SP Billing Changes are specifically documented in IB-4430.  Basically, a System Status of ‘Pre-Registered (Not yet Activated)’ will now show a Listing/Lessor-visible Status of ‘Active’ in the Dashboard.

The automated test case will need to be updated to reflect this system change.  Please go ahead and make the change, and I can make any additional changes resulting from the implementation of IB-4430 post-launch.

This change is dependant on whether new content has been approved main image or not.

Approved content will display 'Active', non-approved content will display 'Under Review'

=cut

sub get_most_recent_property_by_terminate_xt_and_businessmodel_tp_and_newcontent {

    my ( $self, $terminate_xt, $businessmodel_tp, $approved_fg ) = @_;
    
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $property_id = $db->selectrow_array(
		   "SELECT property_id
			FROM(
                SELECT *
                FROM tblproperty, tblnewcontent
                WHERE tblproperty.terminate_xt = '$terminate_xt'
                AND businessmodel_tp = '$businessmodel_tp'
                AND tblproperty.property_id = tblnewcontent.object_id
                AND tblnewcontent.approved_fg = '$approved_fg'
                ORDER BY tblproperty.property_id DESC
			    )
			WHERE rownum <= 1"
	);
	
	chomp $property_id;
	
	print "\n# Property id:  ".$property_id."\n";
	
	$db->disconnect;
		
	return $property_id;
}

=head2 get_most_recent_property_by_businessmodel_tp_is_searchable()

Returns most recent property_id by terminate_xt in tblsearchengine.  Properties in tblsearchengine
are usually active (but modifiable via CS-Tool) and are searchable.

=cut

sub get_most_recent_property_by_businessmodel_tp_is_searchable {

    my ( $self, $businessmodel_tp ) = @_;
    
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $property_id = $db->selectrow_array(
			   "SELECT property_id
                FROM(
                    SELECT  tblsearchengine.property_id, tblsearchengine.businessmodel_tp
                    FROM tblsearchengine, tblpropertydistance 
                    WHERE tblsearchengine.property_id = tblpropertydistance.property_id
                    AND tblsearchengine.businessmodel_tp = '$businessmodel_tp'
				    )
				WHERE rownum <= 1"
		);
	
	chomp $property_id;
	
	print "\n# Property id:  ".$property_id."\n";
	
	$db->disconnect;
		
	return $property_id;
}

1;

}