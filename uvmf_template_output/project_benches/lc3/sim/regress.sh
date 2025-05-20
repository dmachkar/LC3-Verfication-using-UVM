export QUESTA_HOME=/mnt/apps/public/COE/mg_apps/questa2024.2/questasim
# export UVMF_HOME=/mnt/ncsudrive/d/dmachka/748/dmachka_p3/ECE748-LC3-Verification/UVMF_2023.4 #<-------- Put UVMF_HOME directory here

ml questa

make clean

echo -e "\nRunning Tests...\n"
python3 $UVMF_HOME/scripts/uvmf_bcr.py questa verbosity:UVM_LOW test:test_top seed:1404798516 > random_test1_transcript.log
python3 $UVMF_HOME/scripts/uvmf_bcr.py questa verbosity:UVM_LOW test:test_top seed:1248937577 > random_test2_transcript.log
python3 $UVMF_HOME/scripts/uvmf_bcr.py questa verbosity:UVM_LOW test:test_top seed:2188182656 > random_test3_transcript.log
echo -e "\nTests completed...\n"

xml2ucdb -format Excel ./LC3_test_plan.xml ./LC3_test_plan.ucdb
vcover merge -stats=none -strip 0 -totals lc3_test_plan_merged.ucdb ./*.ucdb
visualizer -viewcov ./lc3_test_plan_merged.ucdb