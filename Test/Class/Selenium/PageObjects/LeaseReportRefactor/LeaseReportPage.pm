package Test::Class::Selenium::PageObjects::LeaseReportRefactor::LeaseReportPage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {	
	DDOWN_LENGTHLEASE => "lease_leaseterm_nm",
	
	TFIELD_MOVEINDATE => "movein_dm",
	TFIELD_MONTHLYRENT => "lease_monthlyrent_at",
	RBUTTON_COSIGN_YES => "had_cosigners1",
	RBUTTON_COSIGN_NO => "had_cosigners0",
	
	TFIELD_COSIGN_FIRSTONE => "lease_cosigner_first_1",
	TFIELD_COSIGN_LASTONE => "lease_cosigner_last_1",
	TFIELD_COSIGN_FIRSTTWO => "lease_cosigner_first_2",
	TFIELD_COSIGN_LASTTWO => "lease_cosigner_last_2",
	TFIELD_COSIGN_FIRSTTHREE => "lease_cosigner_first_3",
	TFIELD_COSIGN_LASTTHREE => "lease_cosigner_last_3",
	TFIELD_COSIGN_FIRSTFOUR => "lease_cosigner_first_4",
	TFIELD_COSIGN_LASTFOUR => "lease_cosigner_last_4",
	
	TFIELD_FNAME => "lease_renterfirst_nm",
	TFIELD_LNAME => "lease_renterlast_nm",
	TFIELD_PHONE => "lease_renterphone_cd",

	RBUTTON_FOUNDRENT_YES => "lease_verifyfoundonrentdotcom_fg",
	RBUTTON_FOUNDRENT_NO => "//input[\@id='lease_verifyfoundonrentdotcom_fg' and \@name='lease_verifyfoundonrentdotcom_fg' and \@value='0']",
	RBUTTON_TOLDPROP_YES => "lease_verifytoldproperty_fg",
	RBUTTON_TOLDPROP_NO	=> "//input[\@id='lease_verifytoldproperty_fg' and \@name='lease_verifytoldproperty_fg' and \@value='0']",
	RBUTTON_SIGNEDLEASE_YES => "lease_verifysignedlease_fg", 
	RBUTTON_SIGNEDLEASE_NO => "//input[\@id='lease_verifysignedlease_fg' and \@name='lease_verifysignedlease_fg' and \@value='0']",
	CBOX_VERIFY => "lease_verifyhonestlyanswered_fg",
	BUTTON_SUBMIT => "submitBtn",
	
	BUTTON_PICKB => "submitBtnPickB",
	
	LINK_CHOOSEDATE => "link=Choose date"
};

=head1 NAME

LeaseReportPage

=head1 SYNOPSIS

pageobjects::LeaseReportPage

=head1 DESCRIPTION

This class encapsulates the functionality associated with the Lease Report Page page.

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item $leasereportpage= pageobjects::LeaseReportPage-E<gt>new( %args )

Constructs a new C<pageobjects::LeaseReportPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

=item $leasereportpage-E<gt>submitLeaseReport()

Full user workflow for submitting lease

=cut

sub submit_lease_report {
    my ( $self, $fname, $lname, $move_in_date ) = @_;

	$self->fill_moving_here($fname, $lname, $move_in_date);
	$self->fill_confirm_new_address();
}	


=item $leasereportpage-E<gt>fill_moving_here()

Fill in lease form page 1.

=cut	

sub fill_moving_here(){
#TODO:  need to make this more cleaner, read up on perl overloading.
    
	my ($self, $fname, $lname, $move_in_date, $cosign_fname, $cosign_lname);
	
	#my ( $self, $fname, $lname, $move_in_date ) = @_;
	$self =$_[0];
   	$fname = $_[1];
	$lname = $_[2];
	$move_in_date = $_[3];
    
    $self->click(TFIELD_FNAME);
	$self->type(TFIELD_FNAME, $fname);
    $self->click(TFIELD_LNAME);
	$self->type(TFIELD_LNAME, $lname);
	
	$self->click(LINK_CHOOSEDATE);
	$self->type(TFIELD_MOVEINDATE, $move_in_date);
	$self->click(RBUTTON_COSIGN_YES); #force warning on early or late lease report dates
	
	if (@_ == 6) {	
		$cosign_fname = $_[4];
		$cosign_lname = $_[5];

		$self->click(RBUTTON_COSIGN_YES);
		$self->type(TFIELD_COSIGN_FIRSTONE, $cosign_fname);
		$self->type(TFIELD_COSIGN_LASTONE, $cosign_lname);


	} elsif (@_ == 4) {
	
		$self->click(RBUTTON_COSIGN_YES);
		$self->type(TFIELD_COSIGN_FIRSTONE, "1 co-signer firstname");
		$self->type(TFIELD_COSIGN_LASTONE, "1 co-signer secondname");
		$self->type(TFIELD_COSIGN_FIRSTTWO, "2 co-signer firstname");
		$self->type(TFIELD_COSIGN_LASTTWO, "2 co-signer secondname");
		$self->type(TFIELD_COSIGN_FIRSTTHREE, "3 co-signer secondname");
		$self->type(TFIELD_COSIGN_LASTTHREE, "3 co-signer secondname");
		$self->type(TFIELD_COSIGN_FIRSTFOUR, "4 co-signer secondname");
		$self->type(TFIELD_COSIGN_LASTFOUR, "4 co-signer secondname");
	
	}		
	
}


=item $leasereportpage-E<gt>fill_confirm_new_address()

Fill in lease form new address page.

=cut	

sub fill_confirm_new_address(){
	my ( $self ) = @_;

	#TODO:  Implement new address form
	#$sel->click_ok("//input[\@id='lease_has_different_reward_card_address' and \@name='lease_has_different_reward_card_address' and \@value='1']");
	#$sel->type_ok("lease_rewardcardaddress_nm", "23 sadfoij");
	#$sel->type_ok("lease_rewardcardcity_nm", "Santa Monica");
	#$sel->select_ok("lease_rewardcardstate_cd", "label=CA");
	#$sel->type_ok("lease_rewardcardzip_cd", "90503");
	#$sel->type_ok("lease_renterphone_cd", "(324) 234-2342");
	
	$self->click(BUTTON_SUBMIT);
	$self->wait_for_page_to_load($self->get_page_timeout());
}


sub submit_lease()
{
	my ( $self ) = @_;
	
	$self->click(BUTTON_SUBMIT);
	$self->wait_for_page_to_load($self->get_page_timeout());
}


sub check_for_profanity_filter()
{
	my ( $self, $word ) = @_;
		
	open ( WORDSLIST, '<', "/home/pbautista/workspace/rent/lib/Company/Profanity.pm" );
	
#	while ( <WORDSLIST> )
#	{
#		print "$_";
#	}

	my @arr = <WORDSLIST>;
	
	close( WORDSLIST );
	
	my $start_pos;
	my $end_pos;
	my $idx = 1;
	
	while ( $idx < scalar ( @arr )  )  
	{
		if ( $arr[$idx] =~ m/my \@PROFANE_WORDS/ )
		{
			$start_pos = $idx;
#			print "String at $idx is:  $arr[$idx]\n";
#			print "**Start Pos = $start_pos\n";
		}
		
		if ( $arr[$idx] =~ m/^\);/ )
		{
			$end_pos = $idx;
#			print "String at $idx is:  $arr[$idx]\n";
#			print "**End Pos = $end_pos\n";
		}
		
		$idx++;
	}
	
	my $i = $start_pos + 1;
	my $wordcount = $end_pos;
	
	while ( $i < $wordcount )
	{
		my $profane_word = $arr[$i];
		
#		print "===============================\n";
#		print "Profane word is $profane_word\n";
#		my $profane_word_chomp_len = length ( $profane_word );
#		print "Profane word length is $profane_word_chomp_len\n";
#		print "-------------------------------\n";
		
		$profane_word =~ s/^\s+//; #remove leading spaces
		$profane_word =~ s/\s+$//; #remove trailing spaces
		
#		print "Profane word after removal of spaces = $profane_word\n";
#		print "-------------------------------\n";
		
		my $profane_word_len = length ( $profane_word );
		
#		print "Line $i is = $arr[$i]\n";
#		print "Passed word is $word\n";
#		print "Length of profane word is $profane_word_len\n";
		
		if ( $word =~ m/$profane_word/ )
		{
			print "** The name '$word' contains the word $profane_word. **\n";
			return 1;
		}
		else
		{
			print "** The name '$word' DOES NOT contain the word $profane_word. **\n";
		}
		
		print "===============================\n";
		
		$i++;
	}
	
	return 0;
		
}

1;

}