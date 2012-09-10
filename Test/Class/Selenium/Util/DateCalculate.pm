package Test::Class::Selenium::Util::DateCalculate;

use strict;
use warnings;
use DateTime;
use String::Random;
use Date::Calc qw(:all);
use Date::Parse;
use Date::Format;

=head1 NAME
Test::Class::Selenium::Util::DateCalculate
=head1 SYNOPSIS

=head1 DESCRIPTION
Perform date calculations

=cut

=item $data = Test::Class::Selenium::Util::DateCalculate-E<gt>new( %args )

Constructs a new C<Test::Class::Selenium::Util::DateCalculate> object.

=cut

{
sub new {
    my $class = shift;
    my $self = {};

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}

=over

=item $data-E<gt>create_email()

Generate random email address

=cut
sub create_email
{

	my $str = new String::Random;
	
	return ($str->randregex('[A-Za-z0-9]{10}')."\@mailinator.com");
}

=over

=item $data-E<gt>calculate_num_of_days_between_two_dates($date1, $date2)

Generate random Alpha String

=parameters $date1, $date2

date is in a string format of 'dd-MMM-yy'

=cut

sub calculate_num_of_days_between_two_dates
{
    my ( $self, $date1, $date2 ) = @_;
	
	my $Dd;
	my $year1;
	my $month1;
	my $day1;
	my $year2;
	my $month2;
	my $day2;
	my $newDate1;
	my $newDate2;
		
	$newDate1 = $self->convert_dd_MMM_yy_to_dd_mm_yy($date1);
	$newDate2 = $self->convert_dd_MMM_yy_to_dd_mm_yy($date2);
	
	($day1, $month1, $year1) = ($newDate1 =~ /(\d+)-(\d+)-(\d+)/);
	($day2, $month2, $year2) = ($newDate2 =~ /(\d+)-(\d+)-(\d+)/);
 
	#print "\n".$day1.'-'.$month1.'-'.$year1;
	#print "\n".$day2.'-'.$month2.'-'.$year2;

	$Dd = Delta_Days(	$year1, $month1, $day1, $year2, $month2, $day2);
	
	return ($Dd);
}

=over

=item $data-E<gt>create_email($date)

Convert dd-MMM-yy to dd-mm-yy

=cut
sub convert_dd_MMM_yy_to_dd_mm_yy
{
    my ( $self, $date1 ) = @_;
    
	my $newDate = $date1;
	$newDate =~ s/^(\d{2})-(\d{2})-(\d{4})$/$2-$1-$3/; # Only include this line if you are assuming european style dates.  Ie, the day of the month number comes before the month number       
	my @dateArray = strptime($newDate);
	$newDate = strftime("%d-%m-%y", @dateArray);	

	#print "\nNEWDATE:".$newDate;

	return $newDate;
	
}

1;

}