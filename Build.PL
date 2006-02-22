#!/usr/bin/perl
#

use Module::Build;
use strict;


my $PKGNAME = 'ortp';


# Check for pkg-config
my $pkgconfig = `which pkg-config`;
chomp($pkgconfig);
if ($pkgconfig =~ /not found/) {
	die "Error: pkgconfig is not available on your system";
}

# Check for package
my $pkg_version = `$pkgconfig --modversion $PKGNAME`;
chomp($pkg_version);
if ($pkg_version !~ /^[\d\.]+$/) {
	print $pkg_version;
	exit -1;
} else {
	print "Found $PKGNAME library version $pkg_version.\n";
}

# Check it is new enough
my ($pkg_major, $pkg_minor, $pkg_micro) = split(/\./, $pkg_version);

# FIXME: Better way of doing this?
my $pkg_versnum = ($pkg_major*1000000)+($pkg_minor*1000)+$pkg_micro;
if ($pkg_versnum < 8099) {
	warn "Warning: Version of oRTP may not be new enough (version 0.8.99 or higher is recommended).\n";
}


# Get CFLAGS and LDFLAGS
my $CFLAGS = `$pkgconfig --cflags $PKGNAME`;
my $LDFLAGS = `$pkgconfig --libs $PKGNAME`;
chomp( $CFLAGS, $LDFLAGS );



# Create the Build script
my $build = Module::Build->new
(
	module_name => 'Net::RTP',
	license => 'lgpl',
	build_requires => {
		'Module::Build' => '0.20'
	},
	requires => {
		'Test' => '1.00',
	},
	create_makefile_pl => 'passthrough',
	
	extra_compiler_flags => $CFLAGS,
	extra_linker_flags => $LDFLAGS,
);

$build->create_build_script;
