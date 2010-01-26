#!perl

use strict;
use warnings;
use lib 't/tlib';
use Test::More;
use Test::Deep;
use File::Temp;

use My::Test::Schema;
my $dir = File::Temp->newdir();

My::Test::Schema->connect->create_ddl_dir(['SQLite'], 1, $dir->dirname);

my $schema = My::Test::Schema->last_schema;
isa_ok($schema, 'SQL::Translator::Schema');

my %idx =
  map { $_->name => [$_->fields] } $schema->get_table('table')->get_indices;

cmp_deeply([keys %idx], bag(qw(ix idx1 idx4)));
cmp_deeply($idx{idx1}, ["a"]);
cmp_deeply($idx{idx4}, ["e", "f"]);

done_testing();
