import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rent_car/Features/home/presentation/viewModel/cars_bloc/get_cars_bloc.dart';
import '../../../../../application/core/assets.dart';
import '../../viewModel/addCar/add_car_cubit.dart';

GlobalKey<FormState> addCarKey = GlobalKey();
class AddNewCarBottomSheet extends StatelessWidget {
  const AddNewCarBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCarCubit, AddCarState>(
      listener: (context, state) {
        if(state is AddCarLoading){
          EasyLoading.show();
        }else if(state is AddCarError){
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
        }else{
          EasyLoading.dismiss();
        }
      },
      buildWhen: (curr,next)=>(next is AddCarError)?false:true,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: 510,
              child: Form(
                key: addCarKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView(
                    children: [
                      const SizedBox(height: 12,),
                      TextFormField(
                        validator: (text){
                          if(text!.isEmpty){
                            return "Please enter car name";
                          }else if(text.length > 30){
                            return "car name is too long";
                          }
                        },
                        onSaved: (txt){
                          context.read<AddCarCubit>().carName = txt!;
                        },
                        decoration: InputDecoration(
                            labelText: "Car name",
                            labelStyle: const TextStyle(color: Colors.black),
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                            enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                            focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                            disabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                            errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36)),
                                borderSide: BorderSide(color: Colors.red)),
                            icon: Icon(FontAwesomeIcons.car,color: Assets.appPrimaryWhiteColor,)
                        ),
                      ),
                      const SizedBox(height: 12,),
                      TextFormField(
                        minLines: 2,
                        maxLines: 2,
                        validator: (text){
                          if(text!.isEmpty){
                            return "Please enter car specifications";
                          }
                        },
                        onSaved: (txt){
                          context.read<AddCarCubit>().description = txt!;
                        },
                        decoration: InputDecoration(
                            labelText: "Car Specifications",
                            labelStyle: const TextStyle(color: Colors.black),
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                            enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                            focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                            disabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                            errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36)),
                                borderSide: BorderSide(color: Colors.red)),
                            icon: Icon(FontAwesomeIcons.gears,color: Assets.appPrimaryWhiteColor,)
                        ),
                      ),
                      const SizedBox(height: 12,),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.45,
                            child: TextFormField(
                              validator: (txt){
                                if(txt!.isEmpty || double.parse(txt).runtimeType != double || txt=="" || double.parse(txt) <= 0){
                                  return "Please enter price per day";
                                }else if(double.parse(txt) > 100000){
                                  return "price is too long";
                                }
                              },
                              onSaved: (txt){
                                context.read<AddCarCubit>().price = double.parse(txt!);
                              },
                              decoration:  InputDecoration(
                                  labelText: "Price per day",
                                  labelStyle: const TextStyle(color: Colors.black),
                                  border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                                  enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                                  focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                                  disabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                                  errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36)),
                                      borderSide: BorderSide(color: Colors.red)),
                                  icon: Icon(FontAwesomeIcons.cashRegister,color: Assets.appPrimaryWhiteColor,)
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const Spacer(),
                          TextButton(onPressed: (){
                            context.read<AddCarCubit>().pickImages();
                          }, child: Row(
                            children:  [
                              Icon(FontAwesomeIcons.images,size: 36,color: Assets.appPrimaryWhiteColor),
                              const SizedBox(width: 10,),
                              Text("Add images",style: TextStyle(fontSize: 16,color: Assets.appPrimaryWhiteColor),)
                            ],
                          )),
                        ],
                      ),
                      const SizedBox(height: 12,),
                      TextFormField(
                        validator: (text){
                          if(text!.isEmpty){
                            return "Please enter location";
                          }
                        },
                        onSaved: (txt){
                          context.read<AddCarCubit>().location = txt!;
                        },
                        decoration: InputDecoration(
                            labelText: "Location",
                            labelStyle: const TextStyle(color: Colors.black),
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                            enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                            focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                            disabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36))),
                            errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36)),
                                borderSide: BorderSide(color: Colors.red)),
                            icon: Icon(FontAwesomeIcons.locationPin,color: Assets.appPrimaryWhiteColor,)
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Assets.appPrimaryWhiteColor)
                          ,onPressed: ()async{
                        if(addCarKey.currentState!.validate()){
                          addCarKey.currentState!.save();
                          await context.read<AddCarCubit>().addCar();
                          Navigator.pop(context);
                          context.read<GetCarsBloc>().add(GetFirstCarsEvent());
                        }
                      }, child: const Text("Add car",style: TextStyle(color: Colors.white),))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}