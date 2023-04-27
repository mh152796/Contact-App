const String tableContact = 'tbl_contact';
const String tblContactColId = 'id';
const String tblContactColName = 'name';
const String tblContactColMobile = 'mobile';
const String tblContactColeEmail = 'email';
const String tblContactColAddress = 'address';
const String tblContactColWebsite = 'website';
const String tblContactColImage = 'image';
const String tblContactColCompany = 'company';
const String tblContactColDesignation = 'designation';
const String tblContactColFax = 'fax';
const String tblContactColFavorite= 'favorite';

class ContactModel {
  int id;
  String contactName;
  String mobile;
  String email;
  String address;
  String designation;
  String website;
  String image;
  String fax;
  String company;
  bool favorite;

  ContactModel(
      {this.id = -1,
      required this.contactName,
      required this.mobile,
      this.email = '',
      this.designation = '',
      this.favorite = false,
      this.address = '',
      this.fax = '',
      this.website = '',
      this.image = 'images/person.png',
      this.company = ''});

  factory ContactModel.formMap(Map<String, dynamic> map){
   return ContactModel(
       contactName: map[tblContactColName],
       mobile: map[tblContactColMobile],
       id: map[tblContactColId],
       email: map[tblContactColeEmail],
       address: map[tblContactColAddress],
       website: map[tblContactColWebsite],
       designation: map[tblContactColDesignation],
       company: map[tblContactColCompany],
       image: map[tblContactColImage],
       fax: map[tblContactColFax] ?? '',
       favorite: map[tblContactColFavorite] == 0 ? false : true,

   );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblContactColName : contactName,
      tblContactColMobile : mobile,
      tblContactColeEmail : email,
      tblContactColDesignation : designation,
      tblContactColCompany : company,
      tblContactColAddress : address,
      tblContactColWebsite : website,
      tblContactColImage : image,
      tblContactColFax : fax,
      tblContactColFavorite : favorite? 1 : 0,
    };
    if(id > 0){
      map[tblContactColId] = id;
    }
    return map;
  }


}
