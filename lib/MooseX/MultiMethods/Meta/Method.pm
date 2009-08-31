package MooseX::MultiMethods::Meta::Method;
our $VERSION = '0.06';


use Moose;
use MooseX::Method::Signatures;
use MooseX::Types::Moose qw/CodeRef/;
use Devel::PartialDump qw/dump/;
use aliased 'MooseX::Types::VariantTable';

use namespace::autoclean;

extends 'Moose::Object', 'Moose::Meta::Method';

has _variant_table => (
    is      => 'ro',
    isa     => VariantTable,
    default => sub { VariantTable->new },
    handles => [qw/add_variant/],
);

has body => (
    is      => 'ro',
    isa     => CodeRef,
    lazy    => 1,
    builder => 'initialize_body',
);

method initialize_body {
    my $name          = $self->name;
    my $variant_table = $self->_variant_table;

    return sub {
        my ($args) = \@_;

        if (my ($result, $type) = $variant_table->find_variant($args)) {
            my $method = $result->body;
            goto $method;
        }

        if (my $super = $self->associated_metaclass->find_next_method_by_name($name)) {
            my $method = $super->body;
            goto $method;
        }

        confess "no variant of method '${name}' found for ", dump($args);
    };
}

1;

__END__

=pod

=head1 NAME

MooseX::MultiMethods::Meta::Method

=head1 VERSION

version 0.06

=head1 AUTHOR

  Florian Ragwitz <rafl@debian.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


