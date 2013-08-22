package Mason::Plugin::SliceFilter::t::Basic;
use Test::Class::Most parent => 'Mason::Test::Class';
sub test_slice_filter :Test(2){
  my $self = shift;
  ok(1);
  $self->setup_interp( plugins => [ '@Default', 'SliceFilter' ] );
  $self->test_comp( src =>
q|
% $.Slice(slice_id => 'aslice'){{
Output
% }}
|,
                    expect => 'Output');
}

1;
