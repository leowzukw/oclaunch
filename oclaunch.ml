(******************************************************************************)
(* Copyright � Joly Cl�ment, 2014                                             *)
(*                                                                            *)
(*  leowzukw@vmail.me                                                         *)
(*                                                                            *)
(*  Ce logiciel est un programme informatique servant � ex�cuter              *)
(*  automatiquement des programmes � l'ouverture du terminal.                 *)
(*                                                                            *)
(*  Ce logiciel est r�gi par la licence CeCILL soumise au droit fran�ais et   *)
(*  respectant les principes de diffusion des logiciels libres. Vous pouvez   *)
(*  utiliser, modifier et/ou redistribuer ce programme sous les conditions    *)
(*  de la licence CeCILL telle que diffus�e par le CEA, le CNRS et l'INRIA    *)
(*  sur le site "http://www.cecill.info".                                     *)
(*                                                                            *)
(*  En contrepartie de l'accessibilit� au code source et des droits de copie, *)
(*  de modification et de redistribution accord�s par cette licence, il n'est *)
(*  offert aux utilisateurs qu'une garantie limit�e.  Pour les m�mes raisons, *)
(*  seule une responsabilit� restreinte p�se sur l'auteur du programme,  le   *)
(*  titulaire des droits patrimoniaux et les conc�dants successifs.           *)
(*                                                                            *)
(*  A cet �gard  l'attention de l'utilisateur est attir�e sur les risques     *)
(*  associ�s au chargement,  � l'utilisation,  � la modification et/ou au     *)
(*  d�veloppement et � la reproduction du logiciel par l'utilisateur �tant    *)
(*  donn� sa sp�cificit� de logiciel libre, qui peut le rendre complexe �     *)
(*  manipuler et qui le r�serve donc � des d�veloppeurs et des professionnels *)
(*  avertis poss�dant  des  connaissances  informatiques approfondies.  Les   *)
(*  utilisateurs sont donc invit�s � charger  et  tester  l'ad�quation  du    *)
(*  logiciel � leurs besoins dans des conditions permettant d'assurer la      *)
(*  s�curit� de leurs syst�mes et ou de leurs donn�es et, plus g�n�ralement,  *)
(*  � l'utiliser et l'exploiter dans les m�mes conditions de s�curit�.        *)
(*                                                                            *)
(*  Le fait que vous puissiez acc�der � cet en-t�te signifie que vous avez    *)
(*  pris connaissance de la licence CeCILL, et que vous en avez accept� les   *)
(*  termes.                                                                   *)
(******************************************************************************)

open Core.Std;;

(* Some settins variales *)
let rc_file = "test.json" (* TODO Dev value, change this *)
let tmp_file = "test_tmp.json" (* TODO Dev value, change this *)

(* Obtain data from rc file *)
let rc_content = File_com.init_rc ~rc:rc_file;;

(* Set tmp file, in witch stock launches *)
let tmp_content = File_com.init_tmp ~tmp:tmp_file;;

(* Return true if a program is in the rc file *)
let rec is_prog_in_rc ?(liste_from_rc_file=rc_content.progs) program =
	match liste_from_rc_file with
	(* | None -> is_prog_in_rc program ~liste_from_rc_file:rc_content.progs *)
	| [] -> false
	| hd :: tl -> if hd = program then true else is_prog_in_rc program  ~liste_from_rc_file:tl
;;

(* Log when a program has been launch *)
let log program =
	(* Verify the program exist in rc file *)
	let prog_rc = is_prog_in_rc program in
	match prog_rc with
	| false -> (* failwith *) "Not in configuration file"
	| true -> "Tmp value" (* TODO delete this *)
	(* let open Tmp_log_t in
	File_com.stock_tmp ~target:tmp_content.cmd ~key:program ~value:1 *)
;;

(* Execute some command and log it *)
let execute ?(display=false) cmd =
	if display then
		print_endline cmd;
	Sys.command cmd
	|> print_int;
	log cmd
;;

(* Execute each item in config file *)
List.map ~f:execute rc_content.progs;;