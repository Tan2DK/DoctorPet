import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/data/clinic_model.dart';

class BranchListWidget extends StatelessWidget {
  const BranchListWidget({
    Key? key,
    required this.branchList,
    this.onChanged,
    this.onViewMap,
    this.onDrawLine,
    required this.selectedBranch,
  }) : super(key: key);
  final List<ClinicModel> branchList;
  final Function(ClinicModel?)? onChanged;
  final Function(int, ClinicModel)? onViewMap;
  final Function(int, LatLng)? onDrawLine;
  final ClinicModel? selectedBranch;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return ListView.separated(
      itemCount: branchList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final branch = branchList[index];
        return DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onTap: onChanged == null ? null : () => onChanged?.call(branch),
            isThreeLine: true,
            selected: branch == selectedBranch,
            selectedTileColor: primaryColor,
            selectedColor: Colors.white,
            textColor: branch == selectedBranch ? Colors.white : Colors.black,
            leading: Theme(
              data: ThemeData(unselectedWidgetColor: Colors.red),
              child: SizedBox(
                height: double.maxFinite,
                child: Radio<ClinicModel?>(
                  activeColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.white;
                    }
                    return primaryColor;
                  }),
                  value: branch,
                  groupValue: selectedBranch,
                  onChanged: onChanged == null
                      ? null
                      : (value) => onChanged?.call(value),
                ),
              ),
            ),
            title: Text(
                '${branch.name}  (${branch.distance != null ? (branch.distance! / 1000).toStringAsFixed(1) : ''}km)'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 2, child: Text(branch.address)),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => onViewMap?.call(1, branch),
                        child: Text(
                          'View Map',
                          style: TextStyle(
                            fontSize: 12,
                            color: branch == selectedBranch
                                ? Colors.white
                                : Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: branch.latlng == null
                        ? null
                        : () => onDrawLine?.call(1, branch.latlng!),
                    child: Text(
                      'Direction',
                      style: TextStyle(
                        fontSize: 12,
                        color: branch == selectedBranch
                            ? Colors.white
                            : Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
