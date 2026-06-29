import 'package:flutter/material.dart';


class CategoryForm extends StatelessWidget{

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
   final cnpassword = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();


  void submitData(){
    _form.currentState!.validate();
  }
  Widget build(BuildContext context){
    return SizedBox(
     height: 100,
      child: Card(

        child: Container(
          margin: EdgeInsets.only(top: 200),
          padding: EdgeInsets.all(12),
          width: 300,
          child: Form(
            key: _form,
            child: 
            Column(children: [
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Username'),
                ),
                controller: username,
                validator: (value) => value!.isEmpty ? 'Required Field': '',
              ),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Email'),
      
                ),
                controller: email,
                validator: (value) => !value!.contains('@')? 'Not a valid email address': '',
              ),
              SizedBox(height: 10,),
              TextFormField(
                decoration:  InputDecoration(
                  label: Text('Password'),
                  
                ),
                controller: password,
                validator: (value) => value!.length < 8 ? 'Password too short': '',
              ),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Confirm Password'),

                ),
                controller: cnpassword,
                validator: (value) => cnpassword != password ? 'Password not match': '',
              ),
      
              SizedBox(height: 10,),
      
              ElevatedButton(onPressed: 
                submitData
              , child: Text('Submit Data'))
            ],
            
            ),
            
            ),
        ),
      ),
    );

  } 
}