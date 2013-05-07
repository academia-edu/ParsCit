#
# Copyright 2007 Penn State University
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
package HeaderParse::Config::API_Config;

use FindBin qw($Bin);
require Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

@ISA = qw(Exporter);
@EXPORT =  qw($Classifier $offlineD $Database_Dir $Data_Dir $Tmp_Dir $nMinHeaderLength $nMaxHeaderLength $ServerURL $ServerPort $algName $algVersion);

if ($ENV{'SVM_LIGHT_HOME'}.length) {
  $Classifier = "$ENV{'SVM_LIGHT_HOME'}/svm_classify" 
}
else {
  $Classifier = "svm_classify5"; # assume on path
}

my $path;
BEGIN
{
	if ($FindBin::Bin =~ /(.*)/) { $path = $1; }
}

$Resource_Dir = "$path/../resources/headerParse";
$Database_Dir = "$Resource_Dir/database/";
$Data_Dir = "$Resource_Dir/data/";
$offlineD = "$Resource_Dir/models/";
$Tmp_Dir = "$path/../tmp";

$nMinHeaderLength = 50;
$nMaxHeaderLength = 2500;

%repositories = ('example1' => '/',
		 'example2' => '/home',
		 );

$algName = "SVM HeaderParse";
$algVersion = 0.2;

$ServerPort = 40000;
$ServerURL = "130.203.152.158";
