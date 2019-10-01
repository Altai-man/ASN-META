use ASN::META BEGIN { 'file', slurp 't/test.asn' };
use ASN::Types;
use Test;

my Rocket $rocket = Rocket.new(name => 'Rocker', :fuel(solid),
        speed => Speed.new((mph => 9001)),
        payload => ASNSequenceOf[Str].new(seq => <A B C>));

ok $rocket.speed ~~ Speed, "Subtype enum is generated";
is-deeply Speed.ASN-choice, {kmph => 1 => Int, mph => 0 => Int}, "ASN-choice is added";
is-deeply $rocket.speed.choice-value, (mph => 9001), "Choice value is correct";
ok solid ~~ Fuel, "Enum value is part of Enum";
nok Fuel ~~ solid, "Enum value is not exactly enum";
is $rocket.fuel, solid, "Enum is generated";
is-deeply $rocket.payload.seq, ('A', 'B', 'C'), "Payload is loaded";
is $rocket.message, '"Hello World"', 'Default message works';

done-testing;
