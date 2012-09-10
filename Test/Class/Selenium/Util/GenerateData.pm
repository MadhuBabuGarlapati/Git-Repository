package Test::Class::Selenium::Util::GenerateData;

use strict;
use warnings;
use DateTime;
use String::Random;

=head1 NAME
Test::Class::Selenium::Util::GenerateData
=head1 SYNOPSIS

=head1 DESCRIPTION
Generate data for testcases

=cut

=item $data = Test::Class::Selenium::Util::GenerateData-E<gt>new( %args )

Constructs a new C<Test::Class::Selenium::Util::GenerateData> object.

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
	my $randstr = $str->randregex('[A-Za-z0-9]{10}');
	
	return ("QATEST_".$randstr."\@mailinator.com");
}

=over

=item $data-E<gt>create_alpha_string($number_of_characters)

Generate random Alpha String

=cut

sub create_alpha_string
{
    my ( $self, $num ) = @_;

	my $str = new String::Random;
	
	return ($str->randregex("[A-Za-z]{$num}"));

}

=over

=item $data-E<gt>create_address($number_of_characters)

Generate random address prefixed by 123

=cut

sub create_address
{
    my ( $self, $num ) = @_;

	my $str = new String::Random;
	
	return ("123 ".$str->randregex("[A-Za-z]{$num}"));

}

=over

=item $data-E<gt>get_todays_date_mmddyyyy()

get todays date in mm/dd/yyyy format, with Ameria/Los_angeles time zone.

=cut

sub get_todays_date_mmddyyyy
{
    my ( $self) = @_;

	my $dt = DateTime->now( time_zone => 'America/Los_Angeles' );
	my $str = $dt->mdy('/');
	
	print "# Today's Date: ".$str."\n";
	
	return ($str);

}

=over

=item $data-E<gt>get_todays_date_monthddyyyy()

get todays date in 'month dd,yyyy' format, with Ameria/Los_angeles time zone.

=cut

sub get_todays_date_monthddyyyy
{
    my ( $self) = @_;

	my $dt = DateTime->now( time_zone => 'America/Los_Angeles' );
	my $str = $dt->month_name()." ".$dt->day().", ".$dt->year();
	
	print "# Today's Date: ".$str."\n";
	
	return ($str);

}

=over

=item $data-E<gt>get_todays_date_yyyymmddtt($number_of_characters)

get todays date in 'yyyymmddhhmm' format, with Ameria/Los_angeles time zone.

=cut

sub get_todays_date_yyyymmddhhmmss
{
    my ( $self) = @_;

	my $dt = DateTime->now( time_zone => 'America/Los_Angeles' );
	my $str = $dt->ymd('_')."_".$dt->hour()."".$dt->minute()."".$dt->second();  
	
	print "# Today's Date: ".$str."\n";
	
	return ($str);

}

=over

=item $data-E<gt>get_todays_date_ddmmyy()

get todays date in dd-mm-yy format, with Ameria/Los_angeles time zone.

=cut

sub get_todays_date_ddMMMyy
{
    my ( $self) = @_;

	my $dt = DateTime->now( time_zone => 'America/Los_Angeles' );

	my $year   = $dt->year;
	my $month  = $dt->month_abbr;
	my $day    = $dt->day;
	
	#cut off first 2 digits of year to get preffered display
	my $n    = 2;
    my $yy = substr($year, $n);
	
	my $str = $day.'-'.$month.'-'.$yy;
	
	print "# Year: ".$year."\n";
	print "# Month: ".$month."\n";
	print "# Day: ".$day."\n";
	
	print "# Today's Date: ".$str."\n";
	
	return ($str);

}


1;

}