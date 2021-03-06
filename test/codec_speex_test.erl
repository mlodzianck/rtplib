%%%----------------------------------------------------------------------
%%% Copyright (c) 2008-2012 Peter Lemenkov <lemenkov@gmail.com>
%%%
%%% All rights reserved.
%%%
%%% Redistribution and use in source and binary forms, with or without modification,
%%% are permitted provided that the following conditions are met:
%%%
%%% * Redistributions of source code must retain the above copyright notice, this
%%% list of conditions and the following disclaimer.
%%% * Redistributions in binary form must reproduce the above copyright notice,
%%% this list of conditions and the following disclaimer in the documentation
%%% and/or other materials provided with the distribution.
%%% * Neither the name of the authors nor the names of its contributors
%%% may be used to endorse or promote products derived from this software
%%% without specific prior written permission.
%%%
%%% THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ''AS IS'' AND ANY
%%% EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
%%% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
%%% DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY
%%% DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
%%% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
%%% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
%%% ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
%%% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
%%% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%%%
%%%----------------------------------------------------------------------

-module(codec_speex_test).

-include("rtp.hrl").
-include_lib("eunit/include/eunit.hrl").

codec_speex_test_() ->
	Padding = <<0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0>>,
	Padding2 = <<165,254,168,1,197,254,168,249,21,244,78,243,202,247,
	131,252,190,2,153,8,174,5,85,1,34,9,178,17,115,18,152,5,195,
	247,83,238,156,233,152,231,201,235,99,241,212,253,70,9,25,13,
	159,11,61,13,68,19,230,19,23,10,115,4,190,2,229,255,101,2,114,
	7,229,7,158,12,192,11,176,7,166,14,126,23,27,20,191,5,18,241,
	238,226,250,220,2,218,204,221,240,231,51,246,219,4,234,3,231,
	251,213,252,31,6,44,3,96,253,214,253,176,254,124,2,110,11,96,
	10,138,14,105,24,214,24,202,19,88,29,2,42,39,36,207,17,50,254,
	107,238,175,223,78,215,125,214,74,221,134,233,172,241,97,242,212,243>>,
	[
		{"Test decoding from SPEEX to PCM",
			fun() -> ?assertEqual(
						true,
						(fun() ->
							{ok, BinIn}  = file:read_file("../test/samples/speex/sample-speex-16-mono-8khz.raw"),
							{ok, PcmOut0} = file:read_file("../test/samples/speex/sample-pcm-16-mono-8khz.from_spx"),
							% FIXME padding for the first decoded frame
							PcmOut = <<Padding/binary, PcmOut0/binary, Padding2/binary>>,
							{ok, Codec} = codec:start_link({'SPEEX',8000,1}),
							Ret = test_utils:decode("SPEEX", Codec, BinIn, PcmOut, 38),
							codec:close(Codec),
							Ret
						end)()
%						test_utils:codec_decode(
%							"../test/samples/speex/sample-speex-16-mono-8khz.raw",
%							"../test/samples/speex/sample-pcm-16-mono-8khz.from_spx",
%							38,
%							"SPEEX",
%							{'SPEEX',8000,1}
%						)
					) end
%		},
%		{"Test encoding from PCM to SPEEX",
%			fun() -> ?assertEqual(
%						true,
%						test_utils:codec_encode(
%							"../test/samples/speex/sample-pcm-16-mono-8khz.raw",
%							"../test/samples/speex/sample-speex-16-mono-8khz.from_pcm",
%							320,
%							"SPEEX",
%							{'SPEEX',8000,1}
%						)
%					) end
		}
	].
