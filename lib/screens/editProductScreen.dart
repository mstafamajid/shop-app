import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Product_item_provider.dart';
import 'package:shop_app/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const String id = 'edit_screen';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final imageFieldController = TextEditingController();
  final focusNodePrice = FocusNode();
  final focusNodedescription = FocusNode();
  final focusNodeimage = FocusNode();
  final _form = GlobalKey<FormState>();

  Product edited_product = Product(
    id: '',
    title: '',
    price: 0,
    description: '',
    imgURL: '',
  );
  bool isInit = true;
  bool isnew = true;
  bool isLoading = false;
  @override
  void didChangeDependencies() {
    if (isInit) {
      if (!(ModalRoute.of(context)!.settings.arguments == null)) {
        isnew = false;
        final productid = ModalRoute.of(context)!.settings.arguments as String;
        edited_product =
            Provider.of<Products_Item>(context).findProductById(productid);
        imageFieldController.text = edited_product.imgURL;
      } else {
        imageFieldController.text =
            'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg';
        edited_product = Product(
          id: DateTime.now().toString(),
          title: '',
          price: 0,
          description: '',
          imgURL: '',
        );
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  Future<void> saveForm() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      isLoading = true;
    });
    if (!isnew) {

await Provider.of<Products_Item>(context, listen: false)
          .updateProduct(edited_product);

   
    
    } else {
        try {
        await Provider.of<Products_Item>(context, listen: false)
            .addItem(edited_product);
      } catch (e) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('an error has Occured'),
                  content: const Text(
                      'somethings thats went wrong! please try again later'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: const Text('Okey'))
                  ],
                ));
      } 
    
    }
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
  }

  @override
  void dispose() {
    focusNodeimage.removeListener(_updateimagePreview);
    focusNodePrice.dispose();
    focusNodeimage.dispose();
    focusNodedescription.dispose();
    imageFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    focusNodeimage.addListener(_updateimagePreview);
    super.initState();
  }

  void _updateimagePreview() {
    if (!focusNodeimage.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('editing your item'),
      ),
      body: isLoading
          ? Center(
              child:  SpinKitFadingCube(
                    size: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            )
          : Container(
              padding: const EdgeInsets.all(16),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: edited_product.title,
                      validator: (value) {
                        return value!.isEmpty ? 'please write a title' : null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(label: Text('Title')),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(focusNodePrice);
                      },
                      onSaved: (value) {
                        edited_product = Product(
                            id: edited_product.id,
                            description: edited_product.description,
                            title: value!,
                            imgURL: edited_product.imgURL,
                            price: edited_product.price);
                      },
                    ),
                    TextFormField(
                      initialValue: edited_product.price.toString(),
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(label: Text('price')),
                      keyboardType: TextInputType.number,
                      focusNode: focusNodePrice,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(focusNodedescription);
                      },
                      onSaved: (value) {
                        edited_product = Product(
                          id: edited_product.id,
                          description: edited_product.description,
                          title: edited_product.title,
                          imgURL: edited_product.imgURL,
                          price: double.parse(value!),
                        );
                      },
                      validator: (value) {
                        if (double.tryParse(value!) == null) {
                          return 'please write a price';
                        }
                        if (double.parse(value) <= 0) {
                          return 'please write number greater than 0';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: edited_product.description,
                      maxLines: 2,
                      decoration:
                          const InputDecoration(label: Text('description')),
                      keyboardType: TextInputType.multiline,
                      focusNode: focusNodedescription,
                      onSaved: (value) {
                        edited_product = Product(
                            id: edited_product.id,
                            description: value!,
                            title: edited_product.title,
                            imgURL: edited_product.imgURL,
                            price: edited_product.price);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please write some description';
                        }
                        if (value.length < 10) {
                          return 'please write a description greater than 10 character';
                        }
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10, right: 10),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.black)),
                          alignment: Alignment.center,
                          height: 100,
                          width: 100,
                          child: Container(
                            child: imageFieldController.text.isEmpty
                                ? const Text(
                                    'please enter a image',
                                    textAlign: TextAlign.center,
                                  )
                                : FittedBox(
                                    child: Image.network(
                                    imageFieldController.text,
                                    fit: BoxFit.cover,
                                  )),
                          ),
                        ),
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: imageFieldController,
                          decoration:
                              const InputDecoration(label: Text('image URL')),
                          focusNode: focusNodeimage,
                          onSaved: (value) {
                            edited_product = Product(
                                id: edited_product.id,
                                description: edited_product.description,
                                title: edited_product.title,
                                imgURL: value!,
                                price: edited_product.price);
                          },
                        )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: ElevatedButton(
                          onPressed: () {
                            saveForm();
                          },
                          child: const Text('save')),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
