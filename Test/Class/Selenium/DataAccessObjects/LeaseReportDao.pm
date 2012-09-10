package Test::Class::Selenium::DataAccessObjects::LeaseReportDao;

use strict;
use warnings;
use Test::Class::Selenium::DataAccessObjects::BaseDao;

use base 'Test::Class::Selenium::DataAccessObjects::BaseDao';


=head1 NAME

LandingPage

=head1 SYNOPSIS

dao::LeaseReportDao Package

=head1 DESCRIPTION

This class encapsulates the functionality associated with the LeaseReports data access objects.

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
=head2 get_valid_lease_property_id()

Return lease_id of a valid lease

=cut

sub get_valid_lease_property_id {
	my ( $self ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $property_id = $db->selectrow_array(qq{
	    SELECT tblproperty.property_id
		FROM vwlease_all2, tblproperty
		WHERE vwlease_all2.renterlast_nm is not null
		AND	vwlease_all2.renterfirst_nm is not null
		AND	vwlease_all2.status_xt = 'Valid'
		AND	vwlease_all2.create_dm > sysdate - 180
		AND	vwlease_all2.property_id = tblproperty.property_id
		AND	tblproperty.TERMINATE_XT = 'Active'
		AND rownum 	<=	1
	    
	});
	
	print "\n# Property id from LR DAO:  ".$property_id."\n";
	
	$db->disconnect();
		
	return $property_id;
}

sub modify_property_terminate_date
{
	my ( $self, $property_id, $terminate_date ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	$db->do(qq{
		UPDATE tblproperty
		SET terminate_dm = $terminate_date
		WHERE property_id = $property_id
	});
	
	my $updated_rec = $db->selectrow_array(qq{
			SELECT property_id,
					terminate_dm,
					terminate_xt
			FROM tblproperty
			WHERE property_id = $property_id
	});
	
	print "\n# Updated record = $updated_rec\n";
	
	$db->disconnect();
	
	return $updated_rec;
}

sub check_lease_status {
	my ( $self, $lease_id ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $status_xt = $db->selectrow_array(qq{
	    SELECT vwlease_all2.status_xt
		FROM vwlease_all2
		WHERE vwlease_all2.lease_id = $lease_id
		
	});
	
	print "\n# Lease Status in VWLEASE_ALL2 from LR DAO is:  ".$status_xt."\n";
	
	$db->disconnect();
		
	return $status_xt;
}

sub get_lease_property_id
{
	my ( $self, $lease_id ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $property_id = $db->selectrow_array(qq{
	    SELECT vwlease_all2.property_id
		FROM vwlease_all2
		WHERE vwlease_all2.lease_id = $lease_id
		
	});
	
	print "\n# Lease Property ID in VWLEASE_ALL2 from LR DAO is:  ".$property_id."\n";
	
	$db->disconnect();
		
	return $property_id;
}

sub get_lease_create_dm
{
	my ( $self, $lease_id ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $create_dm = $db->selectrow_array(qq{
	    SELECT vwlease_all2.create_dm
		FROM vwlease_all2
		WHERE vwlease_all2.lease_id = $lease_id
		
	});
	
	print "\n# Lease Create Date in VWLEASE_ALL2 from LR DAO is:  ".$create_dm."\n";
	
	$db->disconnect();
		
	return $create_dm;
}

sub modify_lease_status
{
	my ( $self, $lease_id, $new_status ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	$db->do(qq{
		UPDATE tbllease
		SET status_xt = '$new_status'
		WHERE lease_id = $lease_id
	});
	
	$db->disconnect();
}

sub check_reward_card_status {
	my ( $self, $lease_id ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $status_xt = $db->selectrow_array(qq{
	    SELECT tblrewardcard.status_xt
		FROM tblrewardcard
		WHERE tblrewardcard.lease_id = $lease_id
		
	});
	
	print "\n# Reward Card Status in TBLREWARDCARD from LR DAO is:  ".$status_xt."\n";
	
	$db->disconnect();
		
	return $status_xt;
}

sub check_reward_card_return_date {
	my ( $self, $lease_id ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $return_dm = $db->selectrow_array(qq{
	    SELECT tblrewardcard.return_dm
		FROM tblrewardcard
		WHERE tblrewardcard.lease_id = $lease_id
		AND tblrewardcard.status_xt = 'Canceled'
		
	});
	
	print "\n# Reward Card return_dm in TBLREWARDCARD from LR DAO is:  ".$return_dm."\n";
	
	$db->disconnect();
		
	return $return_dm;
}

sub check_reward_card_cancel_date {
	my ( $self, $lease_id ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $cancel_dm = $db->selectrow_array(qq{
	    SELECT cancel_dm
		FROM tblrewardcard
		WHERE lease_id = $lease_id
		AND status_xt = 'Canceled'
		AND cancel_dm IS NOT NULL
	});
	
	print "\n# Reward Card cancel_dm in TBLREWARDCARD from LR DAO is:  ".$cancel_dm."\n";
	
	$db->disconnect();
		
	return $cancel_dm;
}

sub get_returned_reward_card {
	my ( $self ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $lease_id = $db->selectrow_array(qq{
	    SELECT tblrewardcard.lease_id
		FROM tblrewardcard
		WHERE tblrewardcard.status_xt = 'Canceled'
		AND tblrewardcard.return_dm IS NOT NULL
		AND tblrewardcard.create_dm > '01-JAN-2010'
		AND rownum 	<=	1
	    
	});
	
	print "\n# Lease id from LR DAO:  ".$lease_id."\n";
	
	$db->disconnect();
		
	return $lease_id;
}

sub modify_reward_card_return_date
{
	my ( $self, $lease_id, $new_return_dt ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	$db->do(qq{
		UPDATE tblrewardcard
		SET return_dm = '$new_return_dt'
		WHERE lease_id = $lease_id
	});
	
	$db->disconnect();
}

sub get_reward_card_email_nm
{
	my ( $self, $lease_id ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $email_nm = $db->selectrow_array(qq{
	    SELECT tblrewardcard.email_nm
		FROM tblrewardcard
		WHERE lease_id = $lease_id
	});
	
	print "\n# Email Address from LR DAO:  ".$email_nm."\n";
	
	$db->disconnect();
		
	return $email_nm;
}

sub get_reward_card_creds
{
	my ( $self, $lease_id ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my ( $person_nm, $person_cd ) = $db->selectrow_array(qq{
	    SELECT p.person_nm,
	    	p.person_cd
	    FROM vwlease_all2 l
	    JOIN vwperson p
	    ON l.renter_id = p.person_id
	    WHERE l.lease_id = $lease_id
	});
	
	print "\n# Person Name/Email from LR DAO:  ".$person_nm."\n";
	print "# PW from LR DAO:  ".$person_cd."\n";
	
	$db->disconnect();
	
	return ( $person_nm, $person_cd );
}

sub get_person_email_and_lease_id
{
	my ( $self, $lease_status ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my ( $person_nm, $lease_id, $person_cd ) = $db->selectrow_array(qq{
	    SELECT p.person_nm,
	    	l.lease_id, p.person_cd
		FROM VWLEASE_ALL2 l
		JOIN VWLEASESTATUSHISTORY lsh
		ON l.lease_id = lsh.lease_id
		JOIN VWPERSON p
		ON l.renter_id = p.person_id
		WHERE l.status_xt = '$lease_status'
		AND p.person_nm like ('%mailinator.com')
		AND lsh.create_dm > SYSDATE - 60
		AND rownum <= 1
	});
	
	if ( $person_nm and $lease_id )
	{
		print "\n# Person Email Address from LR DAO:  ".$person_nm."\n";
		print "# Person's Lease ID from LR DAO: ".$lease_id."\n";
		print "# Person's password: ".$person_cd."\n";		
	}
	
	$db->disconnect();
		
	return ( $person_nm, $lease_id, $person_cd );
}

sub get_move_in_date
{
	my ( $self, $lease_id ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $movein_dm = $db->selectrow_array(qq{
	    SELECT tblleaseattribute.movein_dm
		FROM tblleaseattribute
		WHERE lease_id = $lease_id
	});
	
	print "\n# Move-In Date from LR DAO:  ".$movein_dm."\n";
	
	$db->disconnect();
		
	return $movein_dm;
}

sub get_lease_property_name
{
	my ( $self, $lease_id ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $property_nm = $db->selectrow_array(qq{
	    SELECT tbllease.property_nm
		FROM tbllease
		WHERE lease_id = $lease_id
	});
	
	print "\n# Property Name from LR DAO:  ".$property_nm."\n";
	
	$db->disconnect();
		
	return $property_nm;
}

1;

sub get_num_dupe_cosigner_names
{
	my ( $self, $last_name  ) = @_;
	
	my $name = lc ( $last_name );
	
	print "# Renter Last name passed to LR DAO: $name\n";
	
	my $dbh;

	$dbh = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $num_dupe_cosigners = $dbh->selectrow_array(qq{
	    SELECT COUNT(*)
		FROM VWLEASE_ALL2
		WHERE cosigners_nm LIKE ( '%' || '$name' || '%' )
		AND LENGTH(cosigners_nm) > 5
		AND create_dm <= SYSDATE - 90
		AND ROWNUM <= 1
	});
		
	$dbh->disconnect();
	
	print "\n# Num dupe cosigners from LR DAO: $num_dupe_cosigners\n";
		
	return $num_dupe_cosigners;
}

sub get_num_dupe_renter_last_names
{
	my ( $self, $last_name  ) = @_;
	
	my $name = lc ( $last_name );
	
	print "# Cosigner Last name passed to LR DAO: $name\n";
	
	my $dbh;

	$dbh = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $num_dupe_renter_last_names = $dbh->selectrow_array(qq{
	    SELECT COUNT(*)
		FROM VWLEASE_ALL2
		WHERE ( '$name' LIKE ( '%' || NVL(TRIM(LOWER(renterlast_nm)), 'NULL') || '%' ) )
		AND renterlast_nm IS NOT NULL
		AND LENGTH(renterlast_nm) > 5
		AND create_dm <= SYSDATE - 90
		AND ROWNUM <= 1
	});
	
		
	$dbh->disconnect();
	
	print "\n# Num dupe renter last names from LR DAO: $num_dupe_renter_last_names\n";
		
	return $num_dupe_renter_last_names;
}

}