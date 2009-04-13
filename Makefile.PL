
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'MooseX-MultiMethods',
  NAME      => 'MooseX::MultiMethods',
  AUTHOR    => 'Florian\ Ragwitz\ \<rafl\@debian\.org\>',
  ABSTRACT  => 'Multi Method Dispatch based on Moose type constraints',
  VERSION   => '0.01',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "MooseX::Types::Moose" => '0',
    "MooseX::Method::Signatures" => '0.15',
    "namespace::autoclean" => '0',
    "Sub::Install" => '0',
    "Devel::PartialDump" => '0',
    "Devel::Declare" => '0.004000',
    "aliased" => '0',
    "Moose" => '0',
  },
);
