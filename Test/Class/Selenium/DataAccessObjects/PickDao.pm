package Test::Class::Selenium::DataAccessObjects::PickDao;

use strict;
use warnings;
use Test::Class::Selenium::DataAccessObjects::BaseDao;

use base 'Test::Class::Selenium::DataAccessObjects::BaseDao';


=head1 NAME

BillingDao

=head1 SYNOPSIS

dao::PickDao Package

=head1 DESCRIPTION

This class encapsulates the functionality associated with setting Picks (tblpick & tblpickgroup).

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

=head2 password_set_pick_A

Set pick A for optional password

=cut

sub password_set_pick_A {
	my ( $self, $email_id, $password ) = @_;
	
	my $db;
	my $passwordpick = 'Password2011.1.2';
	
	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
=cut

 $person_id = SELECT person_id
 FROM tblperson
 WHERE TRIM(LOWER(person_nm)) = TRIM(LOWER('$email_id');
 
 $group_nm = SELECT group_nm 
 FROM tblpick 
 WHERE group_nm = 'Password2011.1.2' AND object_id = ($person_id);
 
	If we have a test that expects a new user with Pick A OP experience then we run the following query to check if the user is the pick we want:

ACTION:

    - If group_nm = null - then do nothing
    
    else
    
--'DELETE FROM tblpick WHERE group_nm = 'Password2011.1.2' AND object_id = ($person_id);'--
--'UPDATE tblperson SET person_cd = 'qatest11' WHERE person_id = ($person_id);'--
=cut

	my $person_id = $db->selectrow_array(qq{
		SELECT person_id
    	FROM tblperson
    	WHERE TRIM(LOWER(person_nm)) = TRIM(LOWER('$email_id'))

	});

	print "\n#person_id:  ".$person_id;
	
	my $group_nm = $db->selectrow_array(qq{
		SELECT group_nm 
		FROM tblpick 
		WHERE group_nm = '$passwordpick' AND object_id = $person_id
	});

	if (defined $group_nm) {
		print "\n#group_nm:  ".$group_nm;	
		$db->do(qq{
			DELETE FROM tblpick WHERE group_nm = '$passwordpick' AND object_id = $person_id
		});			
	}
	else {
		print "\n#group_nm: null";
	}

	if (!defined $password ){
		$password =  "qatest11";
	}
	$db->do(qq{
		UPDATE tblperson SET person_cd = '$password' WHERE person_id = ($person_id)
	});

	print "\n# Set pick A for optional password \n";
	
	$db->disconnect;

}

=head2 password_set_pick_B

Set pick B for optional password

=cut

sub password_set_pick_B
{
	my ( $self, $email_id ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	#$db->do(qq{
		#TODO: Set Query here 
	#});
	
	print "\n# Set pick B for optional password \n";
	
	$db->disconnect;

}

=head2 search_set_pick_A

Set pick A for search

=cut

sub search_set_pick_A {
	my ( $self, $email_id ) = @_;
	
	my $db;
	my $searchpick = 'Search2011.1.2';

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});

	my $person_id = $db->selectrow_array(qq{
		SELECT person_id
    	FROM tblperson
    	WHERE TRIM(LOWER(person_nm)) = TRIM(LOWER('$email_id'))

	});

	print "\n#person_id:  ".$person_id."\n";
	
	my $group_nm = $db->selectrow_array(qq{
		SELECT group_nm 
		FROM tblpick 
		WHERE group_nm = '$searchpick' AND object_id = $person_id
	});

	if (defined $group_nm) {
		print "\n#group_nm:  ".$group_nm;
	
		$db->do(qq{
			DELETE FROM tblpick WHERE group_nm = '$searchpick' AND object_id = $person_id
		});			
	}
	else {
		print "\n#group_nm: null";
	}
	
	print "\n# Set pick A for Search \n";
	
	$db->disconnect;

}

=head2 hotleadphonenumber_set_pick_A

Set pick A for hot lead phone number

=cut

sub hotleadphonenumber_set_pick_A {
	my ( $self, $email_id ) = @_;
	
	my $db;
	my $hotleadphonenumberpick = 'HotLeadPhoneNumber2011.1.2';
	my $hotleadphonenumberpersonpick = 'HotLeadPhoneNumberPerson2011.1.2';

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});

	my $person_id = $db->selectrow_array(qq{
		SELECT person_id
    	FROM tblperson
    	WHERE TRIM(LOWER(person_nm)) = TRIM(LOWER('$email_id'))

	});

	print "\n#person_id:  ".$person_id."\n";
	
	my $group_nm = $db->selectrow_array(qq{
		SELECT group_nm 
		FROM tblpick 
		WHERE group_nm in ('$hotleadphonenumberpick', '$hotleadphonenumberpersonpick') AND object_id = $person_id
	});

	if (defined $group_nm) {
		print "\n#group_nm:  ".$group_nm;
	}
	else {
		print "\n#group_nm: null";
	}
	
	$db->do(qq{
		DELETE FROM tblpick WHERE group_nm in ('$hotleadphonenumberpick', '$hotleadphonenumberpersonpick') AND object_id = $person_id
	});	

	$db->do(qq{
		commit
	});	
		
	print "\n# Set pick A for Hot Lead Phone number \n";
	
	$db->disconnect;

}

=head2 homepage_get_user_pick_A

Get user pick A for homepage test

=cut

sub homepage_get_user_pick_A {
	my ( $self, $email_id ) = @_;
	
	my $db;
	my $homepagepick = 'Homepage2011';

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});

	my $user_id = $db->selectrow_array(qq{
		SELECT object_id
    	FROM tblpick
    	WHERE group_nm = 'October2011.1.1'
    	AND subpopulation_nb = 2
    	AND rownum <= 1
	});

	print "\n#user_id selected:  ".$user_id."\n";
	
	$db->disconnect;
	
	return $user_id;

}

1;

}